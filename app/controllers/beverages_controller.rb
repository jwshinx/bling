class BeveragesController < ApplicationController
  # GET /beverages
  # GET /beverages.xml
  def index
    @beverages = Beverage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beverages }
    end
  end

  # GET /beverages/1
  # GET /beverages/1.xml
  def show
    @beverage = Beverage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beverage }
    end
  end

  # GET /beverages/new
  # GET /beverages/new.xml
  def new
    @beverages = Beverage.all
    @beverage = Beverage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beverage }
    end
  end

  # GET /beverages/1/edit
  def edit
    @beverage = Beverage.find(params[:id])
  end

  # POST /beverages
  # POST /beverages.xml
  def create
    logger.debug "===> BC.create 0"
    @beverage = Beverage.new(params[:beverage])
    @beverages = Beverage.all

    respond_to do |format|
      if @beverage.save
        logger.debug "===> BC.create 1"
        @beverages = Beverage.all
        flash[:notice] = 'Beverage was successfully created.'
        format.html { redirect_to(beverages_url) }
        format.xml  { render :xml => @beverage, :status => :created, :location => @beverage }
        format.js
      else
        logger.debug "===> BC.create 2"
        format.html { redirect_to(beverages_url) }
        format.xml  { render :xml => @beverage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beverages/1
  # PUT /beverages/1.xml
  def update
    @beverage = Beverage.find(params[:id])

    respond_to do |format|
      if @beverage.update_attributes(params[:beverage])
        flash[:notice] = 'Beverage was successfully updated.'
        format.html { redirect_to(@beverage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beverage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beverages/1
  # DELETE /beverages/1.xml
  def destroy
    @beverage = Beverage.find(params[:id])
    @beverage.destroy

    respond_to do |format|
      format.html { redirect_to(new_beverage_url) }
      format.xml  { head :ok }
    end
  end
end
