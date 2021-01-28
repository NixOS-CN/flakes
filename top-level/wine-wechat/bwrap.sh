#!@shell@
binding=@mountPoints@
binding+=(--ro-bind /run/user /run/user)

for path in $(@coreutils@/bin/cat @out@/share/wechat/nix-closure);do
    binding+=(--ro-bind $path $path)
done

bindsrcs=()
bindsrcs+=(/run/current-system/sw/lib/locale)
bindsrcs+=(/run/opengl-driver)
bindsrcs+=(/run/opengl-driver-32)
bindsrcs+=(/etc/fonts)

for binds in ${bindsrcs[@]};do
    binding+=(--ro-bind $binds $binds)
    for path in $(@nix@/bin/nix path-info -r $(realpath $binds));do
        binding+=(--ro-bind $path $path)
    done
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
