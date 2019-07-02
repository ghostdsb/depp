defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune
  @op_earth 365.25
  @op_mercury 0.2408467 * @op_earth
  @op_venus 0.61519726 * @op_earth
  @op_mars 1.8808158 * @op_earth
  @op_jupiter 11.862615 * @op_earth
  @op_saturn 29.447498 * @op_earth
  @op_uranus 84.016846 * @op_earth
  @op_neptune 164.79132 * @op_earth
  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(:mercury, seconds), do: seconds/(86400 * @op_mercury)
  def age_on(:venus, seconds), do: seconds/(86400 * @op_venus)
  def age_on(:earth, seconds), do: seconds/(86400 * @op_earth)
  def age_on(:mars, seconds), do: seconds/(86400 * @op_mars)
  def age_on(:jupiter, seconds), do: seconds/(86400 * @op_jupiter)
  def age_on(:saturn, seconds), do: seconds/(86400 * @op_saturn)
  def age_on(:uranus, seconds), do: seconds/(86400 * @op_uranus)
  def age_on(:neptune, seconds), do: seconds/(86400 * @op_neptune)
end
