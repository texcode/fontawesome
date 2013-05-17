#!/usr/bin/env ruby

replace = {
    "copyright" => "",
    "lightbulb" => "light_bulb",
    "thumbnails" => "th",
    "thumbnails-large" => "th_large",
    "thumbnails-list" => "th_list",
    "list-ol" => "ol",
    "list-ul" => "ul",
    "hospital-sign" => "h_sign",
    "medical-kit" => "medkit",
    "medical-sign" => "f0fe",
}

x = DATA.read
counter = 0

enc = File.open("fontawesome.enc","w")

enc << "/fontawesome [\n"
x.lines.each do |x|
    x = x.strip
    y = replace[x] || x.gsub(/-/,"_")
    unless y.empty?
        enc << "/#{y}\n"
        counter = counter + 1
    end
end

while counter < 256 do
    enc << "/.notdef\n"
    counter+= 1
end

enc << "] def"
enc.close()

symb = File.open("symbols.tex","w")

counter = 0
x.lines.each do |x|
    x = x.strip
    y = replace[x] || x
    unless y.empty?
        symb << "\\expandafter\\def\\csname faicon@#{x}\\endcsname{\\symbol{#{counter}}}\n"
        counter = counter + 1
    end
end

symb.close()


__END__

adjust
align-center
align-justify
align-left
align-right
ambulance
angle-down
angle-left
angle-right
angle-up
arrow-down
arrow-left
arrow-right
arrow-up
asterisk
backward
ban-circle
bar-chart
barcode
beaker
beer
bell
bell-alt
bold
bolt
book
bookmark
bookmark-empty
briefcase
building
bullhorn
calendar
camera
camera-retro
caret-down
caret-left
caret-right
caret-up
certificate
check
check-empty
chevron-down
chevron-left
chevron-right
chevron-up
circle
circle-arrow-down
circle-arrow-left
circle-arrow-right
circle-arrow-up
circle-blank
cloud
cloud-download
cloud-upload
coffee
cog
cogs
columns
comment
comment-alt
comments
comments-alt
copy
copyright
credit-card
cut
dashboard
desktop
double-angle-down
double-angle-left
double-angle-right
double-angle-up
download
download-alt
edit
eject
envelope
envelope-alt
exchange
exclamation-sign
external-link
eye-close
eye-open
facebook
facebook-sign
facetime-video
fast-backward
fast-forward
fighter-jet
file
file-alt
film
filter
fire
flag
folder-close
folder-close-alt
folder-open
folder-open-alt
font
food
forward
fullscreen
gift
github
github-alt
github-sign
glass
globe
google-plus
google-plus-sign
group
hand-down
hand-left
hand-right
hand-up
hdd
headphones
heart
heart-empty
home
hospital
hospital-sign
inbox
indent-left
indent-right
info-sign
italic
key
laptop
leaf
legal
lemon
lightbulb
link
linkedin
linkedin-sign
list
list-alt
list-ol
list-ul
lock
magic
magnet
map-marker
medical-kit
medical-sign
minus
minus-sign
mobile-phone
money
move
music
off
ok
ok-circle
ok-sign
paper-clip
paste
pause
pencil
phone
phone-sign
picture
pinterest
pinterest-sign
plane
play
play-circle
plus
plus-sign
print
pushpin
qrcode
question-sign
quote-left
quote-right
random
refresh
remove
remove-circle
remove-sign
reorder
repeat
reply
resize-full
resize-horizontal
resize-small
resize-vertical
retweet
road
rss
save
screenshot
search
share
share-alt
shopping-cart
sign-blank
signal
signin
signout
sitemap
sort
sort-down
sort-up
spinner
star
star-empty
star-half
step-backward
step-forward
stethoscope
stop
strikethrough
suitcase
table
tablet
tag
tags
tasks
text-height
text-width
thumbnails
thumbnails-large
thumbnails-list
thumbs-down
thumbs-up
time
tint
trash
trophy
truck
twitter
twitter-sign
umbrella
underline
undo
unlock
upload
upload-alt
user
user-md
volume-down
volume-off
volume-up
warning-sign
wrench
zoom-in
zoom-out
