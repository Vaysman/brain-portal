class AdminController < ApplicationController	

	def index
		username = cookies[:auth_login]
		user_info = User.find_by username: username
		Access.is('settings.groups.delete', user_info.group_id)
			
	end

	###################################GROUPS#####################################
	def groups_create
		if (Access.is('settings.groups.create', @user_info.group_id))
			@action_title = 'groups_create'
			if (params[:group])
				@group = Group.new(group_params)
				if params[:group][:is_default]
					@old_default_group = Group.find_by is_default: true
					if @old_default_group
						@old_default_group.update(:is_default => false)
					end
					@group.is_default = true
				end
					if @group.save
						redirect_to url_for(:controller => :admin, :action => :group_index)
					end
			else
				@group = Group.new
			end
		else
			redirect_to root_path
		end
	end

	def groups_edit
		if (!Access.is('settings.groups.edit', @user_info.group_id))
			redirect_to root_path
		end
		if (!params[:id])
			redirect_to url_for(:controller => :admin, :action => :groups_index)
		end
			@action_title = 'groups_edit'
			@actions = Pages.get_all
			@actions_active = GroupsToRoles.where(:group_id => params[:id]).all
			@actions_title = PagesActions.get_all
			@group = Group.find_by id: params[:id]
				if @group.nil?
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				else
					if (!params[:group])
						render 'groups_edit'
					else
						is_default = params[:group][:is_default].to_i
						new_title = params[:group][:title]
						@group.make_new_default(is_default, new_title)
						if (params[:actions])
							actions = params[:actions]
							GroupsToRoles.change_roles(actions, @group.id)
						end
					redirect_to url_for(:controller => :admin, :action => :groups_index)
					end
				end	
	end

	def groups_delete
		if (Access.is('settings.groups.delete', @user_info.group_id))
			if (params[:id])
				@group = Group.find_by id: params[:id]
				if @group.nil?
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				else
					@group.destroy
					redirect_to url_for(:controller => :admin, :action => :groups_index)
				end
			end
		else
			redirect_to root_path
		end
	end

	def groups_index
		if (Access.is('settings.groups.index', @user_info.group_id))
			@groups = Group.all.paginate(page: params[:page], per_page: 10)
		else
			redirect_to root_path
		end
		
	end



	####################################USERS###########################################
	def users_index
	  if (!Access.is('settings.users.index', @user_info.group_id))
	  	redirect_to root_path
	  end
	  @users = User.all.paginate(page: params[:page], per_page: 20)
	end


	def users_edit
	  if (!Access.is('settings.users.edit', @user_info.group_id))
	  	redirect_to root_path
	  end
	  if (!params[:id])
	  	redirect_to url_for(:controller => :admin, :action => :users_index)
	  end
	  @user = User.find_by id: params[:id]
	  if (params[:user])
	  	@user = @user.set_new_info(params[:user])
	  	if @user.nil?
	  	  redirect_to url_for(:controller => :admin, :action => :users_index)
	  	end
	  end


	end
	####################################################################################


	######################################CATEGORIES####################################
	def categories_index
	  if (!Access.is('settings.categories.index', @user_info.group_id))
	  	redirect_to root_path
	  end
	  @categories = Category.all.paginate(page: params[:page], per_page: 10)
	end

	def categories_create
	  if (!Access.is('settings.categories.create', @user_info.group_id))
	  	redirect_to root_path
	  end
	  @action_title = 'categories_create'
	  if !params[:category]
	  	@category = Category.new
	  else
	  	@category = Category.new(categories_params)
	  	if @category.save
	  	  redirect_to url_for(:controller => :admin, :action => :categories_index)	
	  	end
	  end
	end

	def categories_edit
	  if (!Access.is('settings.categories.edit', @user_info.group_id))
	  	redirect_to root_path
	  end
	  @action_title = 'categories_edit'
	  if !params[:id]
	  	redirect_to url_for(:controller => :admin, :action => :categories_index)
	  end
	  @category = Category.find_by id: params[:id]
	  if params[:category]
	    @category = @category.save_new_data(params[:category])
	    if @category.nil?
	  	  redirect_to url_for(:controller => :admin, :action => :categories_index)
	    end
      else
       @question = @category.question.all.paginate(page: params[:page], per_page: 50)
       @id = params[:id]
	  end
	end

	def categories_delete
	  if (!Access.is('settings.categories.delete', @user_info.group_id))
	  	redirect_to root_path
	  end	
	  if params[:id]
  	    @category = Category.find_by id: params[:id]
  	    @question = @category.question
		@question.destroy
		@category.destroy
  	    redirect_to url_for(index_categories_path)
	  end
	end


	def categories_create_question
	  if (!Access.is('settings.categories.edit', @user_info.group_id))
	  	redirect_to root_path
	  end
	  if params[:id]
	  	@category = Question.get_category(params[:id])
	  end
	  if !params[:question]
	  	@question = Question.new
	  else
	  	@question = Question.new(questions_params)
	  	@question.image = params[:question][:image]
	  	@question.image_file_name = Digest::SHA1.hexdigest(Time.now.to_s+@question[:question])
	  	@question.category_id = params[:id]
	  	if @question.save
  		  redirect_to url_for(:controller => :admin, :action => :categories_edit, :id => params[:id])
  		end
	  end
	end

	def categories_delete_question
	  if (!Access.is('settings.categories.delete', @user_info.group_id))
	  	redirect_to root_path
	  end
	  if params[:id]
	  	@question = Question.find_by id: params[:id]
	  	@category_id = @question.category_id
	  	@question.destroy
	  	redirect_to url_for(edit_category_path(@category_id))
	  end
	end

	####################################################################################

	private
	  def group_params
	    params.require(:group).permit(:title)
	  end
	  def categories_params
	  	params.require(:category).permit(:title, :description)
	  end
	  def questions_params
	  	params.require(:question).permit(:question, :a, :b, :c, :d, :correct_answer)
	  end
	####################################################################################
end
