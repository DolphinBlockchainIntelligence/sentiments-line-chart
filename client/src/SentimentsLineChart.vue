<template>
  <div id="sentiments-line-chart">
    <div v-if="!chartError">
      <div :id="'sentimentsLineChart'+id" style="min-width: 100%; width: 100%; height: 100vh; min-height: 100vh; margin: 0 auto"></div>
    </div>
  </div>
</template>


<script>
import axios from 'axios'
const Highchart = require('highcharts')
const Highstock = require('highcharts/highstock')
const colors = ['#f98a83', '#989898', '#85f77e']
export default {
  name: "sentimentsLineChart",
  props: ['id'],
  data: function data() {
    return {
      chartError: false
    }
  },
  mounted () {
    this.sentimentsLineChart()
  },
  methods: {
    sentimentsLineChart: function () {
      let highchartContainer = 'sentimentsLineChart'+this.id
      let seriesOptions = []
      let seriesCounter = 0
      function createChart () {
        Highstock.stockChart(highchartContainer, {
          chart: {
            spacingBottom: 30
          },
          legend: {
            enabled: true,
            floating: true,
            verticalAlign: 'bottom',
            align:'center',
            y: 30
          },
          rangeSelector: {
            selected: 4
          },
          plotOptions: {
            series: {
              showInNavigator: true
            },
          },
          series: seriesOptions
        })
      }
      const postId = this.$route.params.id
      let names = ['positive', 'neutral', 'negative']
      let component = this
      // axios.get('http://178.218.115.169:5000/btt-sentiments/S'+ postId +'.json')
      axios.get('/dashboard/data/btt-sentiments/S'+ postId +'.json')
      .then(response => {
        let data = response.data
        let chartData = {
          negative: [],
          neutral: [],
          positive: [],
          pointStart: ''
        }
        let dates = []
        let names = ['negative', 'neutral', 'positive']
        chartData.negative = data.chart.negative
        chartData.neutral = data.chart.neutral
        chartData.positive = data.chart.positive
        chartData.pointStart = data.pointStart
        names.forEach(function (name, i) {
          seriesOptions[i] = {
            name: name,
            data: chartData[name],
            color: colors[i],
            pointStart: chartData.pointStart * 10,
            pointInterval: 3600 * 1000 * 24
          }
          seriesCounter += 1
          if (seriesCounter === names.length) {
            createChart()
          }
        })
      })
      .catch(e => {
        this.chartError = true
        this.errors.push(e)
      })
    },
    removeWidget: function () {
      this.$root.$emit('removeWidget', this.id)
    }
  },
  removeWidget: function () {
    this.$root.$emit('removeWidget', this.id)
  }
}
</script>

<style lang="sass">
html
  overflow-x: hidden !important
body
  margin: 0
</style>

<style lang="sass" scoped>
.title
  margin: 0 10px
.highcharts-container, .sentimentsLineChartundefined
  width: 100%
</style>
