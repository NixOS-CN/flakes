#!@shell@
binding=@mountPoints@
for dir in /run/*;do
    if [[ $dir == "/run/current-system" ]];then
        continue
    fi

    if [[ $dir == "/run/booted-system" ]];then
        continue
    fi

    binding+=(--ro-bind $dir $dir)
done

for dir in /run/current-system/*;do
    if [[ $dir == "/run/current-system/nix-config" ]];then
        continue
    fi

    binding+=(--ro-bind $dir $dir)
done

homedir=@fakeHome@

if [[ ! -d $homedir ]];then
    mkdir -p $homedir
fi 

@bubblewrap@/bin/bwrap \
    --dev /dev \
    --ro-bind /nix /nix \
    --ro-bind /etc /etc "${binding[@]}" \
    --bind $homedir $HOME \
    --dev-bind /dev /dev \
    --dir /tmp \
    @script@ "$@"
