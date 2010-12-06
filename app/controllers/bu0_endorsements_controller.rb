class EndorsementsController < ApplicationController
  # GET /endorsements
  # GET /endorsements.xml
  def index
    @endorsements = Endorsement.all
    @beverage = Beverage.find(2)
    @player = Player.find(2)
    logger.debug "==> EC.i 1: #{@endorsements.empty? }"
    logger.debug "==> EC.i 2.1: #{@beverage.inspect }"
    logger.debug "==> EC.i 3.0: #{@player.inspect }"
=begin
    Endorsement.create(:endorseable => @beverage, :player => @player,
                       :endorsement_type => "gold", :cancellation_year => 2019,
                       :name => "spokesperson") 
=end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @endorsements }
    end
  end

  # GET /endorsements/1
  # GET /endorsements/1.xml
  def show
    @endorsement = Endorsement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @endorsement }
    end
  end

  # GET /endorsements/new
  # GET /endorsements/new.xml
  def new
    @endorsement = Endorsement.new
    @beverages = Beverage.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
    @players = Player.find(:all, :order => "lastname ASC",
                     :select => "id, firstname, lastname").map {|p|
                                   ["#{p.lastname}, #{p.firstname}", p.id]}
    @x = Player.find(:first)
    @b = Beverage.find(:all)
    #logger.debug "==> EC.n 1: #{@beverages.class}"
    #logger.debug "==> EC.n 1.1: #{@beverages.empty?}"
    #logger.debug "==> EC.n 1.2: #{@beverages.inspect}"
    logger.debug "==> EC.n 2: #{@players.class}"
    logger.debug "==> EC.n 2.1: #{@players.empty?}"
    logger.debug "==> EC.n 2.2: #{@players.inspect}"
    logger.debug "==> EC.n 3: #{@x.endorsements.inspect}"
    logger.debug "==> EC.n 4: #{@b.class}"
    logger.debug "==> EC.n 4.1: #{@b.empty?}"
    logger.debug "==> EC.n 4.2: #{@b.inspect}"
    logger.debug "==> EC.n 5: #{@beverages.class}"
    logger.debug "==> EC.n 5.1: #{@beverages.empty?}"
    logger.debug "==> EC.n 5.2: #{@beverages.inspect}"

=begin
    @endorsement = Endorsement.find(:all,
                     :select => "id, name, lastname").map {|p|
                                   [p.firstname, p.lastname, p.id]}
=end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @endorsement }
    end
  end

  # GET /endorsements/1/edit
  def edit
    @endorsement = Endorsement.find(params[:id])
  end

  # POST /endorsements
  # POST /endorsements.xml
  def create
    @endorsement = Endorsement.new(params[:endorsement])
    logger.debug "==> EC.c 1: #{params[:endorsement]}"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @endorsement }
    end
=begin
    respond_to do |format|
      if @endorsement.save
        flash[:notice] = 'Endorsement was successfully created.'
        format.html { redirect_to(@endorsement) }
        format.xml  { render :xml => @endorsement, :status => :created, :location => @endorsement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @endorsement.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # PUT /endorsements/1
  # PUT /endorsements/1.xml
  def update
    @endorsement = Endorsement.find(params[:id])

    respond_to do |format|
      if @endorsement.update_attributes(params[:endorsement])
        flash[:notice] = 'Endorsement was successfully updated.'
        format.html { redirect_to(@endorsement) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @endorsement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /endorsements/1
  # DELETE /endorsements/1.xml
  def destroy
    @endorsement = Endorsement.find(params[:id])
    @endorsement.destroy

    respond_to do |format|
      format.html { redirect_to(endorsements_url) }
      format.xml  { head :ok }
    end
  end
end
