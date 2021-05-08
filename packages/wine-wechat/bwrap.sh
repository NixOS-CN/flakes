#!@shell@
binding=@mountPoints@
binding+=(--ro-bind /run/user /run/user)
binding+=(--ro-bind /etc/passwd /etc/passwd)
binding+=(--ro-bind /etc/group /etc/group)

for path in $(@coreutils@/bin/cat @out@/share/wechat/nix-closure);do
    binding+=(--ro-bind $path $path)
done

bindsrcs=()
bindsrcs+=(/run/current-system/sw/lib/locale)
bindsrcs+=(/run/opengl-driver)
bindsrcs+=(/run/opengl-driver-32)
bindsrcs+=(/etc/fonts)
bindsrcs+=(/bin/sh)

for binds in ${bindsrcs[@]};do
    if [[ -e "${binds}" ]];then
        binding+=(--ro-bind $binds $binds)
        for path in $(@nix@/bin/nix path-info -r $(realpath $binds));do
            binding+=(--ro-bind $path $path)
        done
    fi
done

homedir=@fakeHome@

if [[ ! -d $homedir ]];then
    mkdir -p $homedir
fi 

@bubblewrap@/bin/bwrap \
    --dev /dev \
    "${binding[@]}" \
    --bind $homedir $HOME \
    --dev-bind /dev /dev \
    --dir /tmp \
    @script@ "$@"
