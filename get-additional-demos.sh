#!/usr/bin/env bash

set -o errexit
set -o pipefail

SCRIPT="$(basename $0)"
product="Iguazio Data Science Platform"

git_owner=mlrun
git_repo=demos
git_base_url="https://github.com/${git_owner}/${git_repo}" 
git_url="${git_base_url}.git"
user=${V3IO_USERNAME}

USAGE="\
$SCRIPT:
Retrieves latest-release demos from the mlrun/demos GitHub repo.
USAGE: ${SCRIPT} [OPTIONS]
OPTIONS:
  -h|--help   -  Display this message and exit.
  -b|--branch -  Branch name (default is branch equivalent to the current MLRun version).
  -u|--user   -  Username, which determines the directory to which to copy the files - /v3io/users/<username>.
                 Default = \$V3IO_USERNAME (if set to a non-empty string).
  --mlrun-ver -  Determine the branch based on the MLRun version, unless -b/--branch option is specified.
  --dry-run   -  Do not update the files, but rather show the pending changes.
  --no-backup -  Do not backup the current demos directory."

error_exit()
{

# ----------------------------------------------------------------
# Function for exit due to fatal program error
#   Accepts 1 argument:
#     string containing descriptive error message
# ----------------------------------------------------------------
  echo "${SCRIPT}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

error_usage()
{
    echo "${SCRIPT}: ${1:-"Unknown Error"}" 1>&2
    echo -e "$USAGE"
    exit 1
}

while :
do
    case $1 in
        -h | --help) echo -e "$USAGE"; exit 0 ;;
        -b|--branch)
            if [ "$2" ]; then
                branch=$2
                shift
            else
                error_usage "$1: missing branch name"
            fi
            ;;
        --branch=?*)
            branch=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --branch=)         # Handle the case of an empty --branch=
            error_usage "$1: missing branch name"
            ;;
        -u|--user)
            if [ "$2" ]; then
                user=$2
                shift
            else
                error_usage "$1: missing user name"
            fi
            ;;
        --user=?*)
            user=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --user=)         # Handle the case of an empty --user=
            error_usage "$1: missing user name"
            ;;
        --mlrun-ver)
            if [ "$2" ]; then
                mlrun_version=$2
                shift
            else
                error_usage "$1: missing MLRun version"
            fi
            ;;
        --mlrun-ver=?*)
            mlrun_version=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --umlrun-ver=)         # Handle the case of an empty --mlrun-ver=
            error_usage "$1: missing MLRun version"
            ;;
        --dry-run)
            dry_run=1
            ;;
        --no-backup)
            no_backup=1
            ;;
        -*) error_usage "$1: Unknown option"
            ;;
        *) break;
    esac
    shift
done

if [ -z "${user}" ]; then
    error_usage "Missing user name."
fi

if [ ! -z "${dry_run}" ]; then
    echo "Dry run, no files will be copied."
fi

if [ ! -z "${no_backup}" ]; then
    echo "No backup of current demos directory will be created."
fi

if [ -z "${branch}" ]; then

    if [ -z "${mlrun_version}" ]; then
        pip_mlrun=$(pip show mlrun | grep Version) || :

        if [ -z "${pip_mlrun}" ]; then
            error_exit "MLRun version not found. Aborting."
        else
            echo "Detected MLRun ${pip_mlrun}"
            mlrun_version="${pip_mlrun##Version: }"
        fi
    else
        echo "Looking for demos based on specified MLRun version: ${mlrun_version}."
    fi
    
    tag_prefix=`echo ${mlrun_version} | cut -d . -f1-2`
    latest_tag=`git ls-remote --tags --refs --sort='v:refname' "${git_url}" "refs/tags/v${tag_prefix}.*" | tail -n1 | awk '{ print $2}'`
    if [ -z "${latest_tag}" ]; then
        error_exit "No tag found with tag prefix 'v${tag_prefix}.*'. Aborting"
    else
        # Remote the prfix from the tag
        branch=${latest_tag#refs/tags/}
        echo "Detected ${git_url} tag: ${branch}"
    fi
fi

dest_dir="/v3io/users/${user}"
demos_dir="${dest_dir}/demos"
echo "Updating demos from ${git_url} branch ${branch} to '${demos_dir}'..."

temp_dir=$(mktemp -d /tmp/temp-get-demos.XXXXXXXXXX)
trap "{ rm -rf $temp_dir; }" EXIT
echo "Copying to temporary directory '${temp_dir}'..."

tar_url="${git_base_url}/archive/${branch}.tar.gz"
wget -qO- "${tar_url}" | tar xz -C "${temp_dir}" --strip-components 1

if [ -z "${dry_run}" ]; then
    if [ -d "${demos_dir}" ]; then

        if [ -z "${no_backup}" ]; then
            dt=$(date '+%Y%m%d%H%M%S');
            old_demos_dir="${dest_dir}/demos.old/${dt}"

            echo "Moving existing '${demos_dir}' to ${old_demos_dir}'..."

            mkdir -p "${old_demos_dir}"
            cp -r "${demos_dir}/." "${old_demos_dir}" && rm -rf "${demos_dir}"
        else
            rm -rf "${demos_dir}"
        fi
    fi

    echo "Copying files to '${demos_dir}'..."
    mkdir -p "${demos_dir}"
    cp -RT "${temp_dir}" "${demos_dir}"
else
    echo "Files that will be copied to '${dest_dir}':"
    find "${temp_dir}/" -not -path '*/\.*' -type f -printf "%p\n" | sed -e "s|^${temp_dir}/|./demos/|"
fi

echo "Deleting temporary directory '${temp_dir}..."
rm -rf "${temp_dir}"

echo "DONE"
