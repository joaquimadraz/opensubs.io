import React from 'react'
import PropTypes from 'prop-types'

import CurrentUser from 'data/domain/currentUser/CurrentUser'
import Button from 'components/Button'
import Styles from './Styles'

const renderLandingPage = () => {
  return <p>Home</p>
}

const Home = (props) => {
  const { currentUser } = props

  const renderLoggedPage = () => {
    return (
      <div>
        <h3 className="black-70 f4">December 2017</h3>
        <div className="flex">
          <div className="flex-auto">
            <div className="f6 b light-silver">Total</div>
            <span className="f2 b dib mt2 black-70">
              <span className="v-mid">£1661</span>
              <small className="f5 red v-mid ml2">
                <span className="Home--arrow-up dib v-mid red" />
                <span className="dib ml2 v-mid">+ £350</span>
              </small>
            </span>
          </div>
          <div className="flex-auto">
            <div className="f6 b light-silver">
              <span className="subs-pink">Yearly payments</span>
              <small className="ml2">this month</small>
            </div>
            <div className="flex mt2">
              <a href="/" className="flex-auto bg-black pa2 white mr2 db no-underline">
                <div className="f6">IUC</div>
                <div className="b mt2">£268</div>
              </a>
              <a href="/" className="flex-auto bg-black pa2 white db no-underline">
                <div className="f6">Car insurance</div>
                <div className="b mt2">£190</div>
              </a>
            </div>
          </div>
          <div className="mh3 br bw2 b--near-white" />          
          <div className="flex-auto">
            <div className="f6 b light-silver">Next</div>
            <div className="flex mt2">
              <div className="flex-auto">
                <a href="/" className="bg-black pa2 white mr2 db no-underline">
                  <div className="f6">Three</div>
                  <div className="b mt2">£20</div>
                </a>
                <div className="b orange pa2 f7">in 3 days</div>
              </div>
              <div className="flex-auto">
                <a href="/" className="bg-black pa2 white mr2 db no-underline">
                  <div className="f6">Council Tax</div>
                  <div className="b mt2">£101</div>
                </a>
                <div className="b green pa2 f7">in 2 weeks</div>
              </div>
              <div className="flex-auto">
                <a href="/" className="bg-black pa2 white db no-underline">
                  <div className="f6">Internet BT</div>
                  <div className="b mt2">£38</div>
                </a>
                <div className="b green pa2 f7">in 3 weeks</div>
              </div>
            </div>
          </div>
        </div>
        <div className="mv4 bb bw2 b--near-white" />
        <h3 className="black-70 f5 mb2 mt3">Payments</h3>
        <ul className="pl0 mt0">
          <li className="flex justify-around items-center lh-copy ph0-l light-silver">
            <div className="w-40 pa2 f6 b ">Name</div>
            <div className="w-30 pa2 f6 b tc">Next bill date</div>
            <div className="w-20 pa2 f6 b tc">Alerts</div>
            <div className="w-10 pa2 f6 b tr">Amount</div>
          </li>
        </ul>
        <div className="mv4 bb bw2 b--near-white" />
        <div className="flex silver b">
          <div className="flex-none">
            <div>You will be spending <span className="subs-pink">1300£</span> in January 2018.</div>
            <div>That’s <span className="green">35% less</span> than the previous month.</div>
          </div>
          <div className="flex-none ml3">
            <Button>see more</Button>
          </div>
        </div>
      </div>
    )
  }

  return (
    <Styles>
      {currentUser.isLogged ? renderLoggedPage() : renderLandingPage()}
    </Styles>
  )
}

Home.propTypes = {
  currentUser: PropTypes.instanceOf(CurrentUser).isRequired,
}

export default Home
