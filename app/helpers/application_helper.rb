module ApplicationHelper

	### Reverse of url_for - gets URL and returns parameter hash
	### containig controllerm action and params
	def params_for(path, method=nil)
  		Rails.application.routes.recognize_path(path, :method => method)
	end

	### translated link_to based on controller that is pointing to
	def t_link_to(sym=nil, options={}, html_options={}, &block)

		meno = nil
		if sym.class == Symbol
			kontroler = params_for(options)[:controller]
			meno = t("controllers.#{kontroler}.links.#{sym.to_s}")
		end

		if block_given?
			html_options, options, name = options, name, block
       		options ||= {}
			link_to(meno, options, html_options) do
				yield
			end
		else
			link_to(meno, options, html_options)
		end
	end

	### used to parse text written in markdown to html
	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
           	no_intra_emphasis: true,
           	fenced_code_blocks: true,
           	disable_indented_code_blocks: true,
           	autolink: true,
           	tables: true,
           	underline: true,
           	highlight: true,
           	hard_wrap: true
        )
    	return markdown.render(text.strip.gsub("\r\n", '<br>')).html_safe
  	end

    def limit_lines(text, lines=7)
        text.split("<br>")[0..(lines-1)].join("<br>").html_safe
    end

end
