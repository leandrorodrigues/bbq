class EventItem < ApplicationRecord
  belongs_to :event
  has_and_belongs_to_many :participations

  def price(kind)

    base = 0
    if total_price
      #obter numero de adesões
      mens = participations.where(:kind => :men).count
      womans = participations.where(:kind => :woman).count
      childs = participations.where(:kind => :child).count

      factored_total = mens + (womans * woman_factor) + (childs * child_factor)

      base = total_price / factored_total
    else
      base = per_person_price
    end

    factor = 1
    factor = child_factor if kind == 'child'
    factor = woman_factor if kind == 'woman'

    base * factor
  end

  def title_price
    formatted = title

    if total_price
      formatted += ' (' + total_price.to_s + ' a dividir)'
    else
      formatted +=  ' (' + per_person_price.to_s + ' por pessoa)'
    end

    if child_factor != 1
      formatted += ' (Criança paga ' + child_factor.to_s + ')'
    end
    if woman_factor != 1
      formatted += ' (Mulher paga ' + woman_factor.to_s + ')'
    end

    formatted
  end
end
