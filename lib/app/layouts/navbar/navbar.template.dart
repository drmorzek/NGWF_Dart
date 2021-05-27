var NavbarTemplate = '''
  <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <a class="navbar-item" router-link="/">
          <img src="https://bulma.io/images/bulma-logo.png" width="112" height="28">
        </a>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="true" data-target="navbarBasicExample">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div id="navbarBasicExample" class="navbar-end">
        <div class="navbar-start">
          <a class="navbar-item" router-link="/" >
            Home
          </a>

          <a class="navbar-item" router-link="/input" >
            Input
          </a>

          <a class="navbar-item" router-link="/directive">
              Directive
          </a>
        </div>

        
      </div>
    </nav>
''';
