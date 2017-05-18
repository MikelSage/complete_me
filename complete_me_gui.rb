require_relative './lib/complete_me'
require 'shoes/videoffi'


completion = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
completion.populate(dictionary)

Shoes.app(title: "CompleteMe",
   width: 750, height: 537, resizable: false) {
    background "./gui/completemevice.jpg"
    flow do
      image('http://www.iconsdb.com/icons/preview/white/volume-up-4-xxl.png', height: 50, width: 50, margin_left: 15) do
        @v.play
      end
      image('http://www.iconsdb.com/icons/preview/white/mute-2-xxl.png', height: 50, width: 50, margin_left: 5) do
        @v.stop
      end
    end
    flow do
      style(:margin_left => 380, :left => '-25%', :margin_top => 400, :height => 200)
      @edit = edit_line
      button "Suggest" do
        @slot.clear if @slot
        @suggestions = completion.suggest(@edit.text)
        @slot = flow do
          @suggestions.each do |word|
            para(
              link(word, :stroke => white,).click do
                completion.select(@edit.text, word)
              end
            )
          end
        end
        @slot.style(:margin_left => '60%', :left => '-25%', :margin_top => 450, :scroll => true, :height => 20)
      end

      button 'Clear' do
        @slot.clear
      end
    end
    @v = video( "file:///Users/michaelsagapolutele/turing/1module/projects/complete_me/gui/Push_It_To_The_Limit.mp3",
     :autoplay => true)
  }
