class CommandsController < ApplicationController
  before_action :set_command, only: [:show, :edit, :update, :destroy]

  # GET /commands
  # GET /commands.json
  def index
    @categories = Category.all.order(created_at: :desc).limit(5)
    @categories2 = Category.all.order(created_at: :desc).offset(5).limit(5)
    if params[:search] != nil
      @commands = Command.search(params[:search])
      @commands = Command.page(params[:page]).per(15)
      if @commands.empty?()
        @commands = Command.search2(params[:search])
        @commands = Command.page(params[:page]).per(15)
        if @commands.empty?()
          @commands = Command.search3(params[:search])
          @commands = Command.page(params[:page]).per(15)
        end  
      end
    else 
      @commands = Command.all
      @commands = Command.page(params[:page]).per(15)
    end 
  end

  # GET /commands/1
  # GET /commands/1.json
  def show
  end

  # GET /commands/new
  def new
    @command = Command.new
  end

  # GET /commands/1/edit
  def edit
  end

  # POST /commands
  # POST /commands.json
  def create
    @command = Command.new(command_params)

    respond_to do |format|
      if @command.save
        format.html { redirect_to @command, notice: t('Command was successfully created') }
        format.json { render :show, status: :created, location: @command }
      else
        format.html { render :new }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commands/1
  # PATCH/PUT /commands/1.json
  def update
    respond_to do |format|
      if @command.update(command_params)
        format.html { redirect_to @command, notice: t('Command was successfully updated') }
        format.json { render :show, status: :ok, location: @command }
      else
        format.html { render :edit }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commands/1
  # DELETE /commands/1.json
  def destroy
    @command.destroy
    respond_to do |format|
      format.html { redirect_to commands_url, notice: t('Command was successfully destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def command_params
      params.require(:command).permit(:name, :command, :description, :category_id)
    end
end
