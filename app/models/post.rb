class Post < ActiveRecord::Base

	include ModelConcern
	include NestedAttributesGetterConcern

	has_many(
		:post_tags,
		inverse_of: :post,
		dependent: :destroy 
		# destroy references (joins) to tags in post_tags intertable, not created tags
	)
	has_many(
		:tags,
		through: :post_tags
	)
	accepts_nested_attributes_for(
		:tags,
		allow_destroy: true
		#reject_if: lambda { |c| c[:title].blank? } 
		# skip saving empty tag association if field for new tag is not filled
		# but do not raise validation error
	)

	has_many(
		:category_posts,
		inverse_of: :post,
		dependent: :destroy 
	)
	has_many(
		:categories,
		through: :category_posts
	)
	accepts_nested_attributes_for(
		:categories,
		allow_destroy: true,
		reject_if: :no_category_selected
	)

	nested_attrs_getter_for :categories

	validates :title, presence: true
	validates :text, presence: true

	def no_category_selected
		Rails.logger.info "*-------------"
		#!self.category_ids.any?
		#Rails.logger.info self.category_ids
		#Rails.logger.info self.categories
		#self.categories.each { |w| Rails.logger.info "kok #{w.title}" }
		#Rails.logger.info !self.category_ids.any?
		a = self.categories_attributes.map { |k,v| v[:title] }
		#Rails.logger.info a 
		Rails.logger.info a.all?(&:empty?)
		(!self.category_ids.any?)&&(a.all?(&:empty?))
	end

	#def categories_attributes=(attrs)
		#Rails.logger.info "cat attrs #{attrs}"
		#super(attrs)
	#end

	#validate :n

	#def n
		#logger model_name.plural
		#Rails.logger.info "----- #{model_name.plural}"
	#end

end
