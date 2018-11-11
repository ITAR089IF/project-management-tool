document.addEventListener('DOMContentLoaded', e => {
  const workspace_url = 'http://localhost:3000/account/workspaces.json';
  const projects_url = 'http://localhost:3000/account/projects.json';
  const tasks_url = 'http://localhost:3000/account/tasks.json';

  let search = document.getElementById('search');
  let searchResults = document.getElementById('search-results');

  let workspaces = document.getElementById('workspaces');
  let projects = document.getElementById('projects');
  let tasks = document.getElementById('tasks');

  let workspacesBlock = document.getElementById('workspaces-block');
  let projectsBlock = document.getElementById('projects-block');
  let tasksBlock = document.getElementById('tasks-block');

  let timer;

  search.addEventListener('keyup', e => {

    clearTimeout(timer)
    timer = setTimeout(() => {
      if (e.target.value) {
        getData(workspace_url,
          workspaces,
          'workspaces',
          'WORKSPACES',
          e.target.value,
          workspacesBlock,
          'name'
        );

        getData(projects_url,
          projects,
          'projects',
          'PROJECTS',
          e.target.value,
          projectsBlock,
          'name'
        );

        getData(tasks_url,
          tasks,
          'tasks',
          'TASKS',
          e.target.value,
          tasksBlock,
          'title'
        )

        searchResults.style.display = 'block';
      } else {
        workspaces.innerHTML = '';
        projects.innerHTML ='';
        tasks.innerHTML = '';

        searchResults.style.display = 'none';
        workspacesBlock.style.display = 'none';
        projectsBlock.style.display = 'none';
        tasksBlock.style.display = 'none';
      }
    }, 300);
  })

});

function getData(url, innerObject, objectName, title, search, displayObject, field) {
  if (search) {
    fetch(`${url}?search=${search}`)
    .then(responce => { return responce.json() })
    .then(responce => {
      console.log(responce);
      if (responce[objectName].length > 0) {
        displayObject.style.display = 'block';
        innerObject.innerHTML = jsonToHTML(responce[objectName], title, field);
      } else {
        innerObject.innerHTML = '';
        displayObject.style.display = 'none';
      }
    })
    .catch(error => { console.log(error) });
  }
}

function jsonToHTML(data, title, field, objectId, referenceId = null, url) {
  html = `
    <div class='level'>
      <div class='level-left'>
        <div class='level-item'>
          <div class='title is-4'>
            ${title}
          </div>
        </div>
      </div>
    </div>`;

  data.map( element => {
    html += `
      <div class="level is-small">
        <div class="level-left">
          <div class="level-item">
            ${element[field]}
          </div>
        </div>
      </div>`
  });

  return html;
}
