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
    @beverage = Beverage.new
    @players = Player.find(:all, :order => "lastname ASC",
                     :select => "id, firstname, lastname").map {|p|
                                 ["#{p.lastname}, #{p.firstname}", p.id]}

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
    @beverage = Beverage.new(params[:beverage])

    respond_to do |format|
      if @beverage.save
        flash[:notice] = 'Beverage was successfully created.'
        format.html { redirect_to(@beverage) }
        format.xml  { render :xml => @beverage, :status => :created, :location => @beverage }
      else
        format.html { render :action => "new" }
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
      format.html { redirect_to(beverages_url) }
      format.xml  { head :ok }
    end
  end
end
