class AnnouncementController < ApplicationController
  def index
    @announcements = Announcement.sortNew
  end

  # Pokaż wszystkie z danej kategoii
  def view_by_category
    @announcements = Announcement.sortNew
  end

  # Pokaż dane ogłoszenie
  def view
    @announcement = Announcement.find(params[:id])
  end

  # Obsługa dodawania nowego ogłoszenia
  def add
    @announcement = Announcement.new({:title => "Tytuł ogłoszenia"})
    @categories = AnnouncementCategory.all
  end

  def create
    @announcement = Announcement.new(announcement_param)
    if @announcement.save
      flash[:notice] = "Ogłosznie zostało pomyślnie utworzone"
      redirect_to(:controller => 'welcome', :action => 'index')
    else
      @categories = AnnouncementCategory.all
      render('new')
    end
  end

  # Obsługa edycji ogłoszenia
  def edit
    @announcement = Announcement.find(params[:id])
    @categories = AnnouncementCategory.all
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement .update_attributes(announcement_param)
      redirect_to(:action=>'index', :id => @announcement.id)
    else
      @categories = AnnouncementCategory.all
      render('edit')
    end
  end

  def delete
    @announcement = Announcement.find(params[:id])
  end

  def drop
    announcement = Announcement.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

  def announcement_param
    params.require(:announcement).permit(:announcement_category_id, :title, :description, :price_per_hour, :price_per_day)
  end
end
