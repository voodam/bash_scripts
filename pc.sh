alias total_donations="cat_note donate | grep -E '^[0-9 +]+$' | paste -s -d'+' | bc"
alias pc2gdrive="rclone sync $GDRIVE_PATH gdrive: -P --ignore-size --exclude=/external/**"
alias gdrive2fucking_pc="rclone sync gdrive: $GDRIVE_PATH -P"

gel_in_usd() {
  http_get "https://nbg.gov.ge/gw/api/ct/monetarypolicy/currencies/en/json/?currencies=USD&date=${1:-$(date '+%Y-%m-%d')}" |
    jq -r ".[].currencies[].rateFormated"
}

# count_tax 2023-06-29 5000
count_tax() {
  local date="$1"
  local amount="$2"
  bc <<< "`gel_in_usd $date` * $amount"
}

alias add_ge_kb="xfconf-query -c keyboard-layout -p /Default/XkbLayout -s ru,us,ge"
alias rm_ge_kb="xfconf-query -c keyboard-layout -p /Default/XkbLayout -s ru,us"

bye() {
	killall chrome
	if [ ! -z "$@" ] && [ "$@" = "now" ]; then
		sleep 1
	fi
	shutdown $@
}

breath() {
  _() {
    for i in $(seq $2 -1 1); do
      clear
      echo "$1 $i"
      sleep 1
    done
  }

  _ "Circular breathing" 2
  for _ in {1..10}; do
    _ Inhale 4
    _ Hold 1
    _ Exhale 8
  done

  _ "Box breathing" 2
  for _ in {1..10}; do
    _ Inhale 4
    _ Hold 4
    _ Exhale 4
    _ Hold 4
  done

  _ "Cyclic hyperventilation followed by breath retention" 2
  for _ in {1..30}; do
    _ Inhale 2
    _ Exhale 1
  done
  _ Hold 15

  echo Well done!
}
