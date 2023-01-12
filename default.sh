translate() {
  local params="client=gtx&sl=auto&tl=${2:-ru}&dt=t&q=$1"
  local uri="http://translate.googleapis.com/translate_a/single?$params"
  echo "$(http_get "$uri" | sed "s/,,,0]],,.*//g" | awk -F"\"" '{print $2}')"
}

notify_translation() {
  local input="$(xsel -o)"
  local lang="${1:-ru}"
  notify-send "Перевод" "$(translate "$input" "$lang")"
}

sub_path() {
  local cmd=$1
  $cmd "${2}${4}" "${3}${4}"
}

nanoc() (
  src_coloned2nano() { sed -E 's/([^:]+):([0-9]+)/+\2 \1/' <<< "$1"; }
  nano $2 `src_coloned2nano "$1"`
)

smart_select() 	{
  if (( $(count_lines "$1") <= 1 )); then
    echo "$1"
  else
    select item in $1; do
      echo $item
      break
    done
  fi
}

set_coredump() {
  ulimit -c unlimited
  sudo sysctl -w kernel.core_pattern=/tmp/core-%e.%p.%h.%t
}

# aliases
alias grep_simple="grep -RI . -e"
which_pkg() { dpkg -S $(which $1); }
nohup_s() {
  nohup "$@" > /dev/null 2>&1 &
}

# file system
alias dir_size="du -sh"
alias make_own="sudo chown $(whoami):$(whoami)"
alias disk_space="df --output=size,avail,target -h --type ext4"

# network
http_get()       { wget -U "Mozilla/5.0" -qO - "$1"; }
alias show_ports="sudo lsof -i -P -n"
alias public_ip="dig +short myip.opendns.com @resolver1.opendns.com"
local_ip()       { ip -4 addr show $1 | grep -oP '(?<=inet\s)\d+(\.\d+){3'}; }

# lib
count_lines()    { if [ -z "$1" ]; then echo 0; else wc -l <<< "$1"; fi; }
random_str()     { tr -dc ${2:-A-Za-z0-9} </dev/urandom | head -c ${1:-15}; echo; }
gen_pwd()        { random_str ${1:-30} [:graph:]; }

# desktop
set_resolution() { xrandr --output eDP-1 --mode "${1:-1920x1080}"; }
qr_print()       { qrencode -o - -s 10 "$1" | display; }

# dev
NPROC=$(nproc)
alias makej="make -j$NPROC"
