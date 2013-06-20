#!/usr/bin/env ruby

require "fileutils"

replace = {
    "light_bulb" => "lightbulb",
    "th"         => "thumbnails",
    "th_large"   => "thumbnails-large",
    "th_list"    => "thumbnails-list",
    "ol"         => "list-ol",
    "ul"         => "list-ul",
    "h_sign"     => "hospital-sign",
    "medkit"     => "medical-kit",
    "f0fe"       => "medical-sign",
    "_312"       => "external_link_sign",
    "_279"       => "info",
    "_303"       => "rss_sign",
    "_283"       => "eraser",
}

numbers = %w( zero one two three four five six seven eight nine ten)

glyphs_txt = `otfinfo -g FontAwesome.otf`
glyphs = glyphs_txt.split.sort.reject { |g| g == ".notdef" }

counter = 0
encfilenumber = 0
enc = nil
while true
    if counter % 256 == 0
        if encfilenumber > 0
            enc << "] def\n"
            enc.close()
        end
        encfilenumber += 1
        enc = File.open("fontawesome%s.enc" % numbers[encfilenumber],"w")
        enc << "/fontawesome%s [\n" % numbers[encfilenumber]
    end
    glyph = glyphs[counter]
    enc << "/#{glyph}\n"
    counter += 1
    if glyphs[counter] == nil
        break
    end
end


while counter < encfilenumber * 256 do
    enc << "/.notdef\n"
    counter+= 1
end
enc << "] def\n"
enc.close()


#  --------------- encoding files written, now generate the font (tfm,pfb)

TFM = "texmf/fonts/tfm/fontawesome"
ENC = "texmf/fonts/enc/pdftex/fontawesome"
T1  = "texmf/fonts/type1/fontawesome"

FileUtils.mkdir_p(TFM)
FileUtils.mkdir_p(ENC)
FileUtils.mkdir_p(T1)

maplines = []
1.upto(encfilenumber) do |e|
    cmdline = "otftotfm  FontAwesome.otf --literal-encoding  fontawesome#{numbers[e]}.enc --tfm-directory=#{TFM} --encoding-directory=#{ENC} --type1-directory=#{T1} 2>errorlog "
    # puts cmdline
    maplines << `#{cmdline}`.chomp
end

maplines.each do |m|
    puts "\\pdfmapline{+" + m + "}"
end

1.upto(encfilenumber) do |e|
    puts "\\font\\FA" + numbers[e] + "=FontAwesome--fontawesome" + numbers[e]
    FileUtils.mv("fontawesome#{numbers[e]}.enc", ENC)
end


# ----------- font is written, now generate the package support. This file must be included in fontawesome.sty

symb = File.open("fasymbolspdftex.tex","w")

glyphs.each_with_index do |x,i|
    fontnumber = i / 256 + 1
    y = replace[x] || x
    y = y.gsub(/_/, "-")
    symb << "\\expandafter\\def\\csname faicon@#{y}\\endcsname{\\FA#{numbers[fontnumber]}\\symbol{#{i % 256}}}\n"
end

symb.close()
