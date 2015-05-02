class MoveError < StandardError
end

class MoveIntoCheck < MoveError
  def to_s
    "This move would put you into check."
  end
end

class InvalidMove < MoveError
  def to_s
   "You can't move there."
  end
end

class MissingPiece < MoveError
  def to_s
   "There is no piece there."
  end
end

class WrongColor < MoveError
  def to_s
   "That is not your piece."
  end
end


class StillInCheck < MoveError
  def to_s
   "You must get out of check."
  end
end
