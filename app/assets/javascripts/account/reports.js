document.addEventListener('turbolinks:load', () => {
  var graph = document.getElementById('graph');

  if(graph) {
    var canvas_elements = graph.querySelectorAll('.js-report');

    for(var i = 0; i < canvas_elements.length; i++) {
      projectReport(JSON.parse(canvas_elements[i].dataset.graph), canvas_elements[i]);
    }
  }
});

function projectReport(projectData, element) {
  var ctx = document.getElementById(element.id).getContext('2d');
  var projectReport = new Chart(ctx, {
    type: 'doughnut',
    data: {
      datasets: [{
        data: [projectData.complete, projectData.incomplete],
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

function usersProgressReport(usersData, element) {
  users = [];
  completed_tasks = [];

  for(var i in usersData) {
    users.push(i);
    completed_tasks.push(usersData[i]);
  }

  var ctx = document.getElementById(element.id).getContext('2d');
  var userProgressReport = new Chart(ctx, {
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
