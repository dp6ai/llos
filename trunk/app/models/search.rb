class Search
  attr_accessor :type
  attr_accessor :room
  attr_accessor :outdoor

  def initialize(search)
    if search
      @type = search[:type]
      @room = search[:room]
      @outdoor = search[:outdoor]
    end
  end

  def to_s
    "type: [#{@type}] room: [#{@room}] outdoor: [#{@outdoor}]"
  end

  def get_search
    ret = ""
    ret = @type if !@type.blank?
    ret = @room if !@room.blank?
    ret = @outdoor if !@outdoor.blank?
    return ret
  end

  def has_search
    !@type.blank? || !@room.blank? || !@outdoor.blank?
  end
end