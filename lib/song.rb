require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = self.new_by_name(name)
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    if !song
      self.create_by_name(name)
    else
      song
    end
  end

  def self.alphabetical
    self.all.sort_by {|song| song.name}
  end

  def self.new_from_filename(filename)
    song = self.new_by_name(self.get_song_name_from_filename(filename))
    song.artist_name = self.get_artist_name_from_filename(filename)
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.destroy_all
    self.all.clear
  end

  private

  def self.get_song_name_from_filename(filename)
    filename.split(' - ')[1].delete_suffix('.mp3')
  end

  def self.get_artist_name_from_filename(filename)
    filename.split(' - ')[0]
  end

end
