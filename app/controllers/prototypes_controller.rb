class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show,]
  before_action :move_to_login, except: [index, :show]
  before_action :move_to_index,only: [:edit]

  def index  
    @prototypes = Prototype.all
  end
  def new
    @prototype = Prototype.new
  end 
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
      else
        @prototype = Prototype
        render :new, status: :unprocessable_entity
    end
  end  
  def destroy
    #puts "params[:id]の値: #{params[:id]}"
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
  end
  
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
     else
      render :edit, status: :unprocessable_entity
   end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def correct_user
    @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
      redirect_to root_path   #, alert: "You are not authorized to edit this prototype."
    end
  end  
end
