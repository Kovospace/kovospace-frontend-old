class ActionView::Helpers::FormBuilder

  	def errors(field, continue: false)

	    if !@object.errors[field].blank? 
	    	err = ""
	    	if continue
		    	@object.errors[field].each do |e|
		    		err += @template.content_tag(:span, e, class: "validation_error_message")
		    	end
		    else
		    	err += @template.content_tag(:span, @object.errors[field].first, class: "validation_error_message")
		    end
	    	return err.html_safe
	    end
  	end

end
