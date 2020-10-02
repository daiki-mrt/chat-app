class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  # unless => 「was_attached?がtrueじゃないときは、presence: trueがかかる」と理解する
  # 意訳：「画像が付いてるとき以外は、contentは空じゃダメだよ」

  def was_attached?
    self.image.attached?
  end
end
