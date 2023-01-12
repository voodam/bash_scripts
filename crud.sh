# stash
sst() {
  local msg=$(xsel -ob)
  echo "$msg" > $(stash_path "$1")
  echo "Message saved: $msg"
}
getst() {
  local msg=$(cat $(stash_path "$1") 2>/dev/null)
  echo "$msg" | xsel -b
  echo "Message put to clipboard: $msg"
}
ost() {
  local msg=$(cat $(stash_path "$1") 2>/dev/null)
  x-www-browser "$msg" >/dev/null 2>&1
}
stash()      { ls "$STASH_PATH"; }
mvstash()    { mv $(stash_path "$1") $(stash_path "$2"); }
rmstash()    { rm $(stash_path "$1"); }
stash_path() { echo "${STASH_PATH}/${1:-default}"; }

# notes
note()       { editor $(note_path "$1"); }
notes()      { tree --noreport "$NOTE_PATH" | sed 's/\.txt//'; }
cat_note()   { cat $(note_path "$1"); }
mvnote()     { mv $(note_path "$1") $(note_path "$2"); }
rmnote()     { rm $(note_path "$1"); }
note_path()  { echo "$NOTE_PATH/${1:-default}.txt"; }

# bash
edbash() {
  local file=$(bash_path $1)
  editor $file && source $file
}
bash_path()  { echo "$BASH_PATH/${1:-default}.sh"; }

# books
find_book()  { find $BOOKS_PATH -iname "*$1*"; }
read_book()  {
  local book=$(find_book "$1")

  case $(count_lines "$book") in
    0 ) echo Book not found;;
    1 ) xdg-open "$book";;
    * ) printf "Too many books found:\n$book\n";;
  esac
}
