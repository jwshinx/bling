class EndorsementsController < ApplicationController
  # here modify @products array of "new" method.  so that "pepsi" gets passed
  # to in params not id.
  #
  # GET /endorsements
  # GET /endorsements.xml
  def index
    @endorsements = Endorsement.find(:all, :include => :endorseable)
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
    logger.debug "==> EC.n 0: #{params.inspect}"
    @endorsement = Endorsement.new
    @marker = Endorsement.new
    @products = Array.new
    if params[:product] == "Beverage"
      @marker = Beverage.find(:first)
      @products = Beverage.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
      #@beverages.each { |x| x.insert(1, "Beverage") }
    elsif params[:product] == "Fashion"
      @marker = Fashion.find(:first)
      @products = Fashion.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
    elsif params[:product] == "Snack"
      @marker = Snack.find(:first)
      @products = Snack.find(:all, :order => "name ASC",
                     :select => "id, name").map {|b|
                                   [b.name, b.id]}
    else
      logger.debug "==> EC.n 0.1"
      @bev = Beverage.new
      @products.concat(@bev.get_all_for_select)
      @fas = Fashion.new
      @products.concat(@fas.get_all_for_select)
      @sna = Snack.new
      @products.concat(@sna.get_all_for_select)
      logger.debug "==> EC.n 0.4"

      #this returns items that only exist in endorsements
      #not a meta table of all items. need outer join.
      #@zoo = Endorsement.find(:all, 
      #                  :include => [:beverage, :snack, :fashion],
      #                  :joins => [:beverage, :snack, :fashion]).map do |x|
      #                    x.endorseable.name
      #end
      #@fun = Endorsement.find(:all).map { |x| x.endorseable.name }

      #@products.concat(@fashions)
      #@products.concat(@snacks)
      #@e = Endorsement.new
      #@products = @e.get_products_select
=begin
      @products = Endorsement.find(:all, 
                  :select => "endorseable_id, endorseable_type").map {|b|
                                 [b.endorseable.name, b.endorseable_id]}
=end
      #remove this from the above find statement
      #            :include => [:beverage, :fashion, :snack],
    end
    #@beverages.each { |x| @products << x }
    #@fashions.each { |x| @products << x }
    #@snacks.each { |x| @products << x }
    logger.debug "==> EC.n 0.3: #{@products.inspect}"
    logger.debug "==> EC.n 0.4: #{@marker.inspect}"
    logger.debug "==> EC.n 0.5: #{@marker.class}"
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
    logger.debug "==> EC.c 0: #{params[:endorsement]}"
    logger.debug "==> EC.c 0.1: #{params.inspect}"
    @tempEndorsementHash = params[:endorsement]
    @tempPlayer = Player.find(@tempEndorsementHash[:player])
    logger.debug "==> EC.c 0.2: #{@tempEndorsementHash.inspect}"
    logger.debug "==> EC.c 0.3: #{@tempPlayer.inspect}"
    #@tempEndorseable = Snack.find(@tempEndorsementHash[:endorseable])
    #@fun = Endorseable.all
    @fun = Endorsement.find(:all)
    logger.debug "================================================"
    logger.debug "#{@fun.inspect}"
    logger.debug "================================================"
    @tempEndorseable = Beverage.find(:first, 
               :conditions => ["name = ?", @tempEndorsementHash[:endorseable]])
    logger.debug "==> EC.c 0.4: #{@tempEndorseable.nil?}"
    if @tempEndorseable.nil?
      @tempEndorseable = Snack.find(:first, 
               :conditions => ["name = ?", @tempEndorsementHash[:endorseable]])
      logger.debug "==> EC.c 0.41: #{@tempEndorseable.nil?}"
    end
    if @tempEndorseable.nil?
      @tempEndorseable = Fashion.find(:first, 
               :conditions => ["name = ?", @tempEndorsementHash[:endorseable]])
      logger.debug "==> EC.c 0.42: #{@tempEndorseable.nil?}"
    end 
    logger.debug "==> EC.c 0.5: #{@tempEndorseable.class}"
    
    @endorsement = Endorsement.create(:name => @tempEndorsementHash['name'],
           :cancellation_year => @tempEndorsementHash['cancellation_year'],
           :endorsement_type => @tempEndorsementHash['endorsement_type'],
           :player => @tempPlayer,
           :endorseable => @tempEndorseable)

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

    @endorsement = Endorsement.find(params[:id])
    @tempEndorsementHash = params[:endorsement]
    @tempPlayer = Player.find(@endorsement.player_id)
    @tempBeverage = @endorsement.endorseable 
    
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
