document.addEventListener('turbolinks:load', () => {
  var graphs = document.getElementById('graphs');

  if(graphs) {
    var ids = graphs.querySelectorAll('*[id]');

    for(var i = 0; i < ids.length; i++) {
      chart(JSON.parse(ids[i].dataset.graph), ids[i]);
    }
  }
});

function chart(hash, element) {
  var ctx = document.getElementById(element.id).getContext('2d');
  var chart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      datasets: [{
        data: [hash.complete, hash.incomplete],
        backgroundColor: [
          '#daf7A6',
          '#F7DC6F'
        ],
        borderColor: [
          '#daf700',
          '#ffc400'
        ]
      }],
      labels: ['Complete', 'Incomplete']
    },
    options: {
      legend: {
        display: true,
        labels: {
          usePointStyle: true
          }
        },
        title: {
          display: true,
          text: element.dataset.title
        },
        maintainAspectRatio: false
      }
  });
}

function horizontalBar(hash, element) {
  users = [];
  completed_tasks = [];

  for(var i in hash) {
    users.push(i);
    completed_tasks.push(hash[i]);
  }

  var ctx = document.getElementById(element.id).getContext('2d');
  var myBarChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
      datasets: [{
        data: completed_tasks
      }],
      labels: users
    },
    options: {
      legend: {
        display: false
      },
      title: {
        display: true,
        text: element.dataset.title
      },
      maintainAspectRatio: false,
      scales: {
        xAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  });
}