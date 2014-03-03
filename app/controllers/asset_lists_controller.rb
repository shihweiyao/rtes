class AssetListsController < ApplicationController
  # GET /asset_lists
  # GET /asset_lists.json
  def index
    @asset_lists = AssetList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_lists }
    end
  end

  # GET /asset_lists/1
  # GET /asset_lists/1.json
  def show
    @asset_list = AssetList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset_list }
    end
  end

  # GET /asset_lists/new
  # GET /asset_lists/new.json
  def new
    @asset_list = AssetList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_list }
    end
  end

  # GET /asset_lists/1/edit
  def edit
    @asset_list = AssetList.find(params[:id])
  end

  # POST /asset_lists
  # POST /asset_lists.json
  def create
    @asset_list = AssetList.new(params[:asset_list])

    respond_to do |format|
      if @asset_list.save
        format.html { redirect_to @asset_list, notice: 'Asset list was successfully created.' }
        format.json { render json: @asset_list, status: :created, location: @asset_list }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_lists/1
  # PUT /asset_lists/1.json
  def update
    @asset_list = AssetList.find(params[:id])

    respond_to do |format|
      if @asset_list.update_attributes(params[:asset_list])
        format.html { redirect_to @asset_list, notice: 'Asset list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_lists/1
  # DELETE /asset_lists/1.json
  def destroy
    @asset_list = AssetList.find(params[:id])
    @asset_list.destroy

    respond_to do |format|
      format.html { redirect_to asset_lists_url }
      format.json { head :no_content }
    end
  end
end
