document.addEventListener('turbolinks:load', () => {
  globalSearch();
  onFocusChange();
});

function globalSearch() {
  var BLOCK_KEYS = [9, 13, 16, 17, 18, 20, 37, 38, 39, 40];

  var search = document.getElementById('search');
  var searchResults = document.getElementById('search-results');

  var workspaces = document.getElementById('workspaces');
  var projects = document.getElementById('projects');
  var tasks = document.getElementById('tasks');

  var workspacesBlock = document.getElementById('workspaces-block');
  var projectsBlock = document.getElementById('projects-block');
  var tasksBlock = document.getElementById('tasks-block');
  var noContentBlock = document.getElementById('no-content-block');
  var element;

  if (search) {
    search.addEventListener('keyup', e => {
      if(!BLOCK_KEYS.includes(e.keyCode)) {
        var timer;
        element = -1;

        clearTimeout(timer)
        timer = setTimeout(() => {
          if(e.target.value) {
            searchResults.style.display = 'block';

            fetch(Routes.account_search_index_path({ format: 'json', search: e.target.value }))
              .then(response => { return response.json() })
              .then(response => {
                display(response.workspaces, workspacesBlock, workspaces, 'WORKSPACES', 'name');
                display(response.projects, projectsBlock, projects, 'PROJECTS', 'name');
                display(response.tasks, tasksBlock, tasks, 'TASKS', 'title');

                if(response.workspaces.length <= 0 && response.projects.length <= 0 && response.tasks.length <= 0) {
                  noContentBlock.style.display = 'block';
                } else {
                  noContentBlock.style.display = 'none';
                }
              })
              .catch(error => {
                console.log(error);
              });
          } else {
            workspaces.innerHTML = '';
            projects.innerHTML = '';
            tasks.innerHTML = '';

            searchResults.style.display = 'none';
            workspacesBlock.style.display = 'none';
            projectsBlock.style.display = 'none';
            tasksBlock.style.display = 'none';
          }
        }, 300);
      }
    })

    search.addEventListener('keydown', e => {
      var searchItems = document.getElementsByClassName('search-item');

      if ((e.keyCode == 38 || e.keyCode == 40) && searchItems.length > 0) {
        e.preventDefault();

        switch(e.keyCode) {
          case 38:
            if (element == 0) {
              searchItems[element].classList.remove('select-item');
            }

            if (element <= 0) {
              element = searchItems.length;
            }

            element -= 1;

            if (element + 1 < searchItems.length) {
              searchItems[element + 1].classList.remove('select-item');
            }

            searchItems[element].classList.add('select-item');
            searchItems[element].scrollIntoView(false);
            break;

          case 40:
            if (element == 0 || element == searchItems.length - 1) {
              searchItems[element].classList.remove('select-item');
            }

            if(element >= searchItems.length - 1) {
              element = -1;
            }

            element += 1;

            if (element - 1 > 0) {
              searchItems[element - 1].classList.remove('select-item');
            }

            searchItems[element].classList.add('select-item');
            searchItems[element].scrollIntoView(false);
            break;
        }
      }

      if (e.keyCode == 13) {
        e.preventDefault();

        window.location.href = getUrl();
      }
    })
  }
}

function onFocusChange() {
  var search = document.getElementById('search');
  var searchResults = document.getElementById('search-results');
  var searchResultsMouse = false;

  searchResults.addEventListener('mouseenter', () => { searchResultsMouse = true; });
  searchResults.addEventListener('mouseleave', () => { searchResultsMouse = false; });

  search.addEventListener('focus', () => {
    if (search.value) {
      searchResults.style.display = 'block';
    }
  });

  search.addEventListener('blur', () => {
    if (!searchResultsMouse) {
      searchResults.style.display = 'none';
    }
  });
}

function display(data, displayObject, innerObject, title, field) {
  if(data.length > 0) {
    displayObject.style.display = 'block';
    innerObject.innerHTML = jsonToHTML(data, title, field);
  } else {
    innerObject.innerHTML = '';
    displayObject.style.display = 'none';
  }
}

function getUrl() {
  element = document.getElementsByClassName('select-item')[0];
  return element.getElementsByTagName('a')[0].href;
}

function jsonToHTML(data, title, field) {
  var html = `
    <div class='level'>
      <div class='level-left'>
        <div class='level-item'>
          ${title}
        </div>
      </div>
    </div>
  `;

  data.map( element => {
    var link = '';

    switch(title) {
      case "WORKSPACES":
        link = linkToWorkspace(element.id, element.name);
        break;
      case "PROJECTS":
        link = linkToProject(element.id, element.workspace_id, element.name);
        break;
      case "TASKS":
        link = linkToTask(element.id, element.project_id, element.title);
        break;
    }

    html += `
      <div class="level is-small search-item">
        <div class="level-left">
          <div class="level-item">
            ${ link }
          </div>
        </div>
      </div>`
  });

  return html;
}

var linkToWorkspace = (id, text) => {
  return `<a href="${Routes.account_workspace_path(id)}">> ${text}</a>`;
}

var linkToProject = (id, workspaceId, text) => {
  return `<a href="${Routes.account_workspace_project_path(workspaceId, id)}">> ${text}</a>`;
}

var linkToTask = (id, projectId, text) => {
  return `<a href="${Routes.account_project_task_path(projectId, id)}">> ${text}</a>`;
}
