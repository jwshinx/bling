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
    @fashions = Fashion.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
    @snacks = Snack.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
    @products = Array.new
    #@beverages << @abeverages << @fashions << @snacks
    @beverages.each { |x| @products << x }
    @fashions.each { |x| @products << x }
    @snacks.each { |x| @products << x }
    logger.debug "==> EC.n 0: #{@beverages.inspect}"
    logger.debug "==> EC.n 0.1: #{@products.inspect}"
=begin
  below is the way to get stuff for dropdown from endorsement
  via interface endorseable
    @beverages = Endorsement.find(:all,
                 :select => "endorseable_id, endorseable_type").map {|b|
                               [b.endorseable.name, b.endorseable_id]}
=end
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
    logger.debug "==> EC.e 1: #{params}"
    #@endorsement = Endorsement.find(params[:id])

    @endorsement = Endorsement.find(params[:id])
    logger.debug "==> EC.e 1.1: #{@endorsement.inspect}"
    @tempPlayer = Player.find(@endorsement.player)
    logger.debug "==> EC.e 1.2: #{@tempPlayer.inspect}"

    @beverages = Beverage.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
    logger.debug "==> EC.e 1.3: #{@beverages.inspect}"
    logger.debug "==> EC.e 2: #{@endorsement.inspect}"
    logger.debug "==> EC.e 3.0: #{@endorsement.player.id}"
    logger.debug "==> EC.e 3.1: #{@endorsement.endorseable.name}"
    logger.debug "==> EC.e 3.2: #{@endorsement.endorsement_type}"
    logger.debug "==> EC.e 3.3: #{@endorsement.name}"
    logger.debug "==> EC.e 3.4: #{@endorsement.cancellation_year}"
    @endorsement

  end

  # POST /endorsements
  # POST /endorsements.xml
  def create
    @tempEndorsementHash = params[:endorsement]
    @tempPlayer = Player.find(@tempEndorsementHash['player'])
    @tempBeverage = Beverage.find(@tempEndorsementHash['beverage'])
    #@endorsement = Endorsement.new(params[:endorsement])
    logger.debug "==> EC.c 1: #{params[:endorsement]}"
    logger.debug "==> EC.c 1.1: #{@tempBeverage.class}"
    
    @endorsement = Endorsement.create(:name => @tempEndorsementHash['name'],
           :cancellation_year => @tempEndorsementHash['cancellation_year'],
           :endorsement_type => @tempEndorsementHash['endorsement_type'],
           :player => @tempPlayer,
           :endorseable => @tempBeverage)

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
  end

  # PUT /endorsements/1
  # PUT /endorsements/1.xml
  def update
    logger.debug "==> EC.u 1: #{params.inspect}"
    logger.debug "==> EC.u 1.1: #{params[:endorsement]}"
    @endorsement = Endorsement.find(params[:id])
    logger.debug "==> EC.u 1.15 #{@endorsement.inspect}"
    @tempEndorsementHash = params[:endorsement]
    logger.debug "==> EC.u 1.2: #{@tempEndorsementHash}"
    @tempPlayer = Player.find(@endorsement.player_id)
    logger.debug "==> EC.u 1.3: #{@tempPlayer.inspect}"
    #@tempBeverage = Beverage.find(@tempEndorsementHash['beverage'])
    @tempBeverage = Beverage.find(@endorsement.endorseable)
    #@endorsement = Endorsement.new(params[:endorsement])
    logger.debug "==> EC.u 1.4: #{@tempBeverage.inspect}"
    
    respond_to do |format|
      #if @endorsement.update_attributes(params[:endorsement])
      if @endorsement.update_attributes(:name => @tempEndorsementHash['name'],
           :cancellation_year => @tempEndorsementHash['cancellation_year'],
           :endorsement_type => @tempEndorsementHash['endorsement_type'],
           :player => @tempPlayer,
           :endorseable => @tempBeverage)
      
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
