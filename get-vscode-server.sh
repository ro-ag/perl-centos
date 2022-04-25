#!/bin/bash
set -ex;

echo "installing vscode-server"

repo=microsoft/vscode
tag=$(curl  -s "https://api.github.com/repos/$repo/releases/latest" | jq -r '.tag_name')

echo "version $tag"

read type tag_sha < <(echo $(curl -s "https://api.github.com/repos/$repo/git/ref/tags/$tag" | jq -r '.object.type,.object.sha'))

commit_id=$tag_sha

echo "commit_id $commit_id"
if [[ "$type" != "commit" ]]; then
    commit_id=$(curl -s "https://api.github.com/repos/$repo/git/tags/$tag_sha" | jq '.object.sha')
fi

echo "echo downloading"
curl --progress-bar -sSL "https://update.code.visualstudio.com/commit:${commit_id}/server-linux-x64/stable" -o /tmp/vscode-server-linux-x64.tar.gz
mkdir -p ~/.vscode-server/bin/${commit_id}
echo "echo unpacking"
tar zxf /tmp/vscode-server-linux-x64.tar.gz -C ~/.vscode-server/bin/${commit_id} --strip 1
touch ~/.vscode-server/bin/${commit_id}/0
echo "done"
