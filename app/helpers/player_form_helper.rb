module PlayerFormHelper
  def player_form(player:, heading: "Add a player", &block)
    form_for player do |form|
      output = <<~FORM
        #{ show_errors_for(player) }
        <fieldset>
          <legend>#{heading}</legend>
          <p>
            #{form.label(:name) { %Q(Name <abbr title="required">*</abbr>).html_safe }}
            #{form.text_field(:name, required: true)}
          </p>

          #{ capture(form, &block) if block_given? }

          <p>
            #{form.submit("Save")}
          </p>
        </fieldset>
      FORM
      output.html_safe
    end
  end

  private

  def show_errors_for(player)
    if player.errors.any?
      <<~HTML
      <h3>Errors</h3>
      <ul>
        #{ error_messages_for(player).join }
      </ul>
      HTML
    end
  end


  def error_messages_for(player)
    player.errors.full_messages.map do |msg|
      "<li>#{ msg }</li>"
    end
  end
end
