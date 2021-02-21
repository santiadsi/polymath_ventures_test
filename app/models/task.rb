class Task < ApplicationRecord
  belongs_to :user

  validates :description, :user, presence: true
  validates :complete, inclusion: { in: [true, false] }

  filterrific(
   available_filters: [
     :search_query
   ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    query = query.to_s
    terms = query.downcase.split(/\s+/)

    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    conds = Array.new
    conds.push("LOWER(tasks.description) LIKE ?")
    where(
      terms.map { |term|
        conds.join(" OR ")
      }.join(' AND '),
      *terms.map { |e| [e] * conds.length }.flatten
    )
  }
end
