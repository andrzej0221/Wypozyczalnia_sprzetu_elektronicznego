class AnnouncementController < ApplicationController

  before_action :verify_login, only: [:add, :edit, :update, :delete, :drop, :show_user_announcement]
  before_action :admin_login, only: [:index]

  def index
    @announcements = Announcement.sortNew
  end

  # Obsługa dodawania nowego ogłoszenia
  def add
    @announcement = Announcement.new({:price_per_day => "0", :price_per_hour =>"0"})
    @categories = AnnouncementCategory.all
    @photo = Photo.new
    @user_id = User.find(params[:id]).id
  end

  def create
    @announcement = Announcement.new(announcement_param)
    @announcement.update_attributes(:user_id => session[:user_id])

    if @announcement.save
      @photo = Photo.new
      @photo.update_attributes(:announcement_id => @announcement.id)
      @photo.update_attributes(:image => params[:announcement][:image])

      @photo1 = Photo.new
      @photo1.update_attributes(:announcement_id => @announcement.id)
      @photo1.update_attributes(:image => params[:announcement][:image1])

      @photo2 = Photo.new
      @photo2.update_attributes(:announcement_id => @announcement.id)
      @photo2.update_attributes(:image => params[:announcement][:image2])

      @photo3 = Photo.new
      @photo3.update_attributes(:announcement_id => @announcement.id)
      @photo3.update_attributes(:image => params[:announcement][:image3])

      @photo4 = Photo.new
      @photo4.update_attributes(:announcement_id => @announcement.id)
      @photo4.update_attributes(:image => params[:announcement][:image4])
    end


    if @announcement.save and @photo.save
      redirect_to(:controller => 'welcome', :action => 'index')
    else
      @announcement.destroy
      @categories = AnnouncementCategory.all
      render('add')
    end
  end

  # Obsługa edycji ogłoszenia
  def edit
    @announcement = Announcement.find(params[:id])
    @categories = AnnouncementCategory.all
    # @photo = @announcement.photo
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update_attributes(announcement_param)
      redirect_to(:action=>'index', :id => @announcement.id)
    else
      @categories = AnnouncementCategory.all
      if session[:user].is_admin
        render('edit')
      else
        render('show_user_announcement')
      end
    end
  end

  def delete
    @announcement = Announcement.find(params[:id])
  end

  def drop
    announcement = Announcement.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

  def search
    @search_announcemets = Announcement.search(params[:search])
    @photos = Photo.all
    render('search')
  end

  # Pokaż wszystkie z danej kategoii
  def view_by_category
    @announcements = Announcement.sortNew
    @announcements_all = Announcement.all
    @category = AnnouncementCategory.find(params[:id])
    @photos = Photo.all
  end

  # Pokaż dane ogłoszenie
  def show
    @announcement = Announcement.find(params[:id])
    @photos = Photo.sortOldPhotos
  end

  def show_user_announcement
    @announcements = Announcement.sortNew
    @photos = Photo.all
  end

  def announcement_param
    # DODAŁEM :user_id, brak zapisu w bazie danych user_id, reszta przechodzi :/
    params.require(:announcement).permit(:announcement_category_id, :title, :description, :price_per_hour, :price_per_day)
  end

  def photo_param
    params.require(:announcement).permit(:image)
  end
end
