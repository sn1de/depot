module ApplicationHelper

  def showtime
    #Time.now.strftime("%-d %b, %Y")
    l Time.now, format: :nav
  end
end
