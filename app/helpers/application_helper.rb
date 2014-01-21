module ApplicationHelper

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def showtime
    #Time.now.strftime("%-d %b, %Y")
    l Time.now, format: :nav
  end
end
