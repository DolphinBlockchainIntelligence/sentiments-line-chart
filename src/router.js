import Vue from 'vue'
import Router from 'vue-router'
import SentimentsLineChart from '@/SentimentsLineChart'

Vue.use(Router)
export default new Router({
  routes: [
    {
      path: '/sentiments-line-chart/:id',
      name: 'SentimentsLineChart',
      component: SentimentsLineChart,
      props: true,
      meta: { reuse: false }
    }
  ]
})
