class ActionView::Helpers::FormBuilder

  	def errors(field, continue: false, full_msgs: true)

	    if !@object.errors[field].blank?
	    	html = ""
            errs = full_msgs ? @object.errors.full_messages_for(field) : @object.errors[field]
	    	if continue
		    	errs.each do |e|
		    		html += @template.content_tag(:span, e, class: "validation_error_message")
		    	end
		    else
		    	html += @template.content_tag(:span, errs.first, class: "validation_error_message")
		    end
	    	return html.html_safe
	    end
  	end

  	def error_class(field)
  		if !@object.errors[field].blank?
  			return "error"
  		end
  	end

end
