require_relative './lib/complete_me'

completion = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
completion.populate(dictionary)

Shoes.app(title: "CompleteMe",
   width: 750, height: 537, resizable: false) {
    background "./gui/completemevice.jpg"
    flow do
      style(:margin_left => '55%', :left => '-25%', :margin_top => '75%')
      @edit = edit_line
      button "Add" do
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
        @slot.style(:margin_left => '60%', :left => '-25%', :margin_top => '85%')
      end

      button 'Clear' do
        @slot.clear
      end
    end
    @v = video( "gui/billie-jean.mp3", :autoplay => true)
  }
