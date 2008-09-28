class ChartsController < ApplicationController
  before_filter :login_required

  def mpg_chart_code
      @vehicle = Vehicle.find(params[:vehicle_id])
      
      title = Title.new("MPG")

      line = LineHollow.new
      line.width = 1
      line.colour = '#6363AC'
      line.dot_size = 5
      line.values = @vehicle.fill_ups.collect {|fillup| fillup.miles_per_gallon }
      
      avg_line = Line.new
      avg_line.width = 2
      avg_line.colour = '#99CC33'
      avg_line.values = [@vehicle.overall_miles_per_gallon] * @vehicle.fill_ups.size
      
      x_labels = XAxisLabels.new
      x_labels.set_vertical()
      x_labels.labels = @vehicle.fill_ups.collect {|fillup| XAxisLabel.new(fillup.date.to_s, '#0000ff', 10, 'vertical')}

      x = XAxis.new
      x.set_labels(x_labels)

      x_legend = XLegend.new("Refuel Date")
      x_legend.set_style('{font-size: 20px; color: #778877}')
      
      y = YAxis.new
      y.set_range(30, 50, 5)
      
      y_legend = YLegend.new("Miles Per Gallon")
      y_legend.set_style('{font-size: 20px; color: #770077}')
      
      chart = OpenFlashChart.new
      chart.set_title(title)
      chart.set_x_legend(x_legend)
      chart.set_y_legend(y_legend)
      chart.x_axis = x
      chart.y_axis = y
      
      chart.add_element(line)
      chart.add_element(avg_line)
      
      render :text => chart.to_s
    end

    def cpg_chart_code
        @vehicle = Vehicle.find(params[:vehicle_id])

        title = Title.new("Dollars Per Gallon")

        line = LineHollow.new
        line.width = 1
        line.colour = '#6363AC'
        line.dot_size = 5
        line.values = @vehicle.fill_ups.collect {|fillup| fillup.cost_per_gallon.dollars }

        x_labels = XAxisLabels.new
        x_labels.set_vertical()
        x_labels.labels = @vehicle.fill_ups.collect {|fillup| XAxisLabel.new(fillup.date.to_s, '#0000ff', 10, 'vertical')}

        x = XAxis.new
        x.set_labels(x_labels)

        x_legend = XLegend.new("Refuel Date")
        x_legend.set_style('{font-size: 20px; color: #778877}')

        # todo: this should be dynamic at 0.25 less than the minimum fill up to 0.25 greater than maximum.
        y = YAxis.new
        y.set_range(2.00, 5.00, 0.25)

        y_legend = YLegend.new("Cost Per Gallon")
        y_legend.set_style('{font-size: 20px; color: #770077}')

        chart = OpenFlashChart.new
        chart.set_title(title)
        chart.set_x_legend(x_legend)
        chart.set_y_legend(y_legend)
        chart.x_axis = x
        chart.y_axis = y

        chart.add_element(line)

        render :text => chart.to_s
      end

end
