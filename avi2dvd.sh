# Проверялось на Ubuntu-системах с звуковым сервером PulseAudio и
# выбранным пунктом "Аналоговое стерео выход" (выбирается с помощью
# pavucontrol). Разрешение "1360x768" заменить на свое.
#
# qtrle + wav (видео без потери качества и несжатый звук)
ffmpeg -f alsa -ac 2 -i pulse -r 25 -g 120 -s 1360x768 -f x11grab -i :0.0 -acodec pcm_s16le -vcodec qtrle `date +%F-%k%M`.mov
#
# lossless h264 + wav (видео без потери качества и несжатый звук)
ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 25 -s 1360x768 -i :0.0 -vcodec libx264 -vpre lossless_ultrafast -threads 0 -acodec pcm_s16le `date +%F-%k%M`.mkv
#
# Далее получившийся файл можно сконвертировать в формат для YouTube
# с помощью OggConvert или так:
ffmpeg -i $1 -vcodec libx264 -vpre hq -crf 22 -acodec libmp3lame -ab 192000 -threads 2 converted_$1.mp4
#
# wav (несжатый звук)
ffmpeg -f alsa -ac 2 -i pulse -acodec pcm_s16le -vcodec qtrle `date +%F-%k%M`.wav



ffmpeg -benchmark_all -re -y -i I\ WANT\ TO\ BE-91487833.mp4 -map 0 -vcodec libvpx -aq 6 -acodec libvorbis  I\ WANT\ TO\ BE-91487833ttttttt.mkv
ffmpeg -y -i I\ WANT\ TO\ BE-91487833.mp4 -map 0 -vf "scale=hd720" -vcodec libvpx -aq 6 -acodec libvorbis  I\ WANT\ TO\ BE-91487833ttttttt.mkv

for f in *.VOB ; do ffmpeg -y -i "$f" -map 0 -vcodec libx264 -vpre hq -acodec libvorbis -aq 6 "${f}.mkv" ; done

for f in *.VOB ; do ffmpeg -y -i "$f" -map 0 -vcodec libx264 -vpre libx264-ipod640 -acodec libvorbis -aq 6 "${f}.mkv" ; done


me: это как пример, но его надо чуть изменить, выставить качество и какие дорожки будут браться и кодироваться из исходника
me: for INPUTFILE in `find ./ -type f -iname '*.flv' -or -iname '*.FLV'` ; do
OUTFILE=`echo ${INPUTFILE} | sed -e "s/[Ff][Ll][Vv]/mp4/"`
ffmpeg -y -i ${INPUTFILE} ${OUTFILE}
done
me: а самое простое что-то вроде:
for f in *.VOB ; do ffmpeg -y -i "$f" "${f}.mkv" ; done
me: но тут параметры качества и дорожек у ffmpeg не выставлены
me: но для быстрого теста вполне сойдет

me: for f in *.VOB ; do ffmpeg -y -i "$f" -map 0 -vcodec libx264 -vpre hq -acodec libvorbis -aq 6 "${f}.mkv" ; done
me: цикл на shell ( в цикле `for` помещаем все файлы `*.VOB` в переменную `f` и потом даем команду `ffmpeg` выполнить одно и тоже действие над всеми файлами в переменной `f`  ) про ffmpeg, -y это указание перезаписывать без предупреждения выходной файл если он существует, -i это указание на входной файл (в нашем случае это переменная "$f" в которую мы поместили до этого все файлы с расширением .VOB ), -map 0 это указание ffmpeg что мы хотим все дорожки (аудио видео что-то еще) кодировать\копировать из исходного файла, -vcodec libx264 это указание на использование видеокодека для всех дорожек видео какие нужно кодировать, -vpre hq это пресет качества кодирования, hq=high quality=высокое кач-во, -acodec тоже самое только про аудио кодек, для всех дорожек аудио использовать libvorbis, -aq 6 это качество аудио, 6 значит VBR192 kbit\per\sec , ну и "${f}.mkv" это будет название выходных файлов, название берется из переменной "$f" и добавляется к нему .mkv, done это завершение цикла `for`
me: последнее сообщение где пояснения по поводу консольной команды `ffmpeg` в теле цикла `for` ? так там же все просто, я описал что делается в нем, кратко: это консольная конструкия шелла (bash) -- цикл `for`, в теле этого цикла мы выполняем: создать переменную, скажем `f` и поместить в нее все файлы с расширением .VOB (*.VOB) в текущем каталоге (где мы находимся), затем мы даем команду для ffmpeg чтобы он прогнал через себя (в нашем случае перекодировал данные из файлов .VOB в .mkv) все эти файлы и на выходе создал .mkv файлы с теми же именами что и наши входные файлы .VOB, по завершении программы ffmpeg над всеми файлами .VOB  цикл `for` завершается , конструкция цикла приведена для автоматизации обработки *всех файлов* .VOB в текущей директории за одну консольную команду
me: поправка: "...скажем `f` и поместить в нее все имена файлов с расширением .VOB (*.VOB) ..."
me: http://ru.wikipedia.org/wiki/FFmpeg
me: компоненты



  If no such file is found, then ffmpeg will search for a file named codec_name-arg.ffpreset in the above-mentioned directories, where codec_name is the name of the codec to which the preset file options will be applied.
  For example, if you select the video codec with "-vcodec libvpx" and use "-vpre 1080p", then it will search for the file libvpx-1080p.ffpreset.

  You can transcode decrypted VOBs:

  ffmpeg -i snatch_1.vob -f avi -c:v mpeg4 -b:v 800k -g 300 -bf 2 -c:a libmp3lame -b:a 128k snatch.avi

  This is a typical DVD ripping example; the input is a VOB file, the output an AVI file with MPEG-4 video and MP3 audio. Note that in this command we use B-frames so the MPEG-4 stream is DivX5 compatible, and GOP size
  is 300 which means one intra frame every 10 seconds for 29.97fps input video. Furthermore, the audio stream is MP3-encoded so you need to enable LAME support by passing "--enable-libmp3lame" to configure.  The mapping
  is particularly useful for DVD transcoding to get the desired audio language.

  To force CBR video output:
  ffmpeg -i myfile.avi -b 4000k -minrate 4000k -maxrate 4000k -bufsize 1835k out.m2v

libvpx-1080p.ffpreset
libvpx-1080p50_60.ffpreset
libvpx-360p.ffpreset
libvpx-720p.ffpreset
libvpx-720p50_60.ffpreset
libx264-ipod320.ffpreset
libx264-ipod640.ffpreset

#######################################################################

ffmpeg -i film.avi -aspect 4:3 -target pal-dvd dvd.mpg

#code
! /bin/bash
# bash script for creating a pal dvd
# movie is sneakers!
mencoder -oac lavc -ovc lavc -of mpeg -mpegopts format=dvd:tsaf \
-vf scale=720:576,harddup -srate 48000 -af lavcresample=48000 \
-lavcopts
vcodec=mpeg2video:vrc_buf_size=1835:vrc_maxrate=9800:vbitrate=5000:\
keyint=15:vstrict=0:acodec=ac3:abitrate=192:aspect=16/9 -ofps 25 \
-o sneakers.mpg sneakers.avi
#code

2. Добавим субтитры с помощью spumux

Создадим два XML-файла с содержимым ниже, и сохраним их в качестве
"filmRUS.xml" и "filmENG.xml" (то есть, для каждого языка).

#code
<subpictures>
    <stream>
       <textsub filename="filmRUS.srt" characterset="cp1251"
                    fontsize="28.0" font="devedesans.ttf"
horizontal-alignment="left"
                    vertical-alignment="bottom" left-margin="60"
right-margin="60"
                    top-margin="20" bottom-margin="30" subtitle-fps="25"
                    movie-fps="25" movie-width="720" movie-height="574"
                    force="yes"
        />
     </stream>
</subpictures>
#code

Кодировку указываем исходя из того, в какой кодировке исходные файлы с
субтитрами.

XML-файлы содержат информацию, необходимую для spumux. Имена опций
говорят сами за себя. Шрифт можно использовать любой понравившийся,
присутствующий в системе.

Теперь создаём MPG-файл с субтитрами:

#code
spumux -s0 filmRUS.xml filmRUS.mpg
rm film.mpg
spumux -s1 filmENG.xml filmRUSENG.mpg
rm filmRUS.mpg
#code

3. Создаём файловую систему DVD при помощи dvdauthor в два этапа:

Создаём простой текстовый файл со следующим содержимым и сохраняем его
как auth.xml

#code
<dvdauthor>
    <vmgm />
    <titleset>
        <titles>
            <subpicture lang="ru"/>
            <subpicture lang="en" />
            <pgc>
                <vob file="filmRUSENG.mpg" />
            </pgc>
        </titles>
    </titleset>
</dvdauthor>
#code

и вводим следующую команду в терминале:

#code
dvdauthor -o mydvd -x auth.xml
#code

В результате чего получим файловую систему DVD в директории mydvd.

4. Осталось записать всё это добро на диск!

#code
growisofs -Z /dev/dvd -dvd-video mydvd/
#code

Опция -Z сотрёт диск, если он не будет пустым.

#######################################################################
