class Image
  attr_accessor :active_pixels, :blurred_pixels, :data

  def initialize data = []
    @data = data
    @blurred_pixels = []
  end

  def output_image
    @data.each do |row|
      row.each do |pixel|
        print pixel
      end
      puts
    end
  end

  def blur distance = 1
    starting_distance = 1
    while starting_distance <= distance do
      set_active_pixels()
      @active_pixels.each do |pixel|

        blur_single_pixel pixel
      end

      starting_distance += 1
    end

    output_image()
  end

  private
  def set_active_pixels
    @active_pixels = []
    @data.each_with_index do |row, row_index|
      row.each_with_index do |pixel, pixel_index|
        @active_pixels.push [row_index, pixel_index] if pixel == 1 && !@blurred_pixels.include?(pixel)
      end
    end
  end

  def blur_single_pixel pixel
    @data[pixel.first - 1][pixel.last] = 1 if pixel.first != 0
    @data[pixel.first + 1][pixel.last] = 1 if pixel.first != @data.length - 1 
    @data[pixel.first][pixel.last - 1] = 1 if pixel.last != 0
    @data[pixel.first][pixel.last + 1] = 1 if pixel.last != @data[pixel.first].length - 1
    @blurred_pixels.push pixel
  end
end

image = Image.new([
  [0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
])
image.blur(2)