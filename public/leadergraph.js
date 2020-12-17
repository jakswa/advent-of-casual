import * as _ from 'https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.bundle.min.js';

const COLORMAP = {"red":"rgb(255, 99, 132)","orange":"rgb(255, 159, 64)","yellow":"rgb(255, 205, 86)","green":"rgb(75, 192, 192)","blue":"rgb(54, 162, 235)","purple":"rgb(153, 102, 255)","grey":"rgb(201, 203, 207)"};
const COLORS = Object.values(COLORMAP);

var colorInd = 0;
function nextColor() {
  return COLORS[colorInd++ % COLORS.length];
}

function buildChart(json) {
  var ctx = document.querySelector('#myChart');
  var myLineChart = new Chart(ctx, {
      type: 'line',
      data: buildData(json),
      options: {
        scales: {
          xAxes: [{
            type: 'time',
            distribution: 'series'
          }],
        //  yAxes: [{ stacked: true }]
        }
      }
  });
}

function buildData(json) {
  var starCount = 0;
  var data = { datasets: []};
  var members = Object.values(json.members).filter(member => member.stars > 0);
  var now = new Date();
  members.forEach(member => {
    var color = nextColor();
    var set = { fill: false, borderColor: color, label: member.name, data: [] };
    var days = member.completion_day_level;
    var starCount = 0;
    for (var day in days) {
      for (var star in days[day]) {
        var ts = days[day][star].get_star_ts;
        starCount += 1;
        set.data.push({x: new Date(parseInt(ts) * 1000), y: starCount });
      }
    }
    //set.data.push({x: now, y: starCount });
    data.datasets.push(set);
  });
  return data;
}


fetch('/leaderboard.json')
  .then(res => res.json())
  .then(json => buildChart(json));
