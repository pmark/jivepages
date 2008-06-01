module BoxesHelper

  #
  #
  #
  def render_box(box, mode)
    # begin
      render :file => box.partial_name(mode), :locals => {:box => box}
    # rescue ActionView::ActionViewError
      logger.warn "ERROR rendering box: #{$!}"
      box.content
    # end
  end
end
