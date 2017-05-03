# Yo; Sup?

`sup` wraps [Yeoman](http://yeoman.io/)'s `yo` so that it is installed _globally_, outside of any particular Node installation, along with any generators that you would like to be global.

_But why!?_  Because it can be challenging to manage your yeoman generators (and keep them in sync across node installations) when you have a multitude of projects that span multiple node versions.  `sup` lets you set up your generators once, and not have to worry!


## Installation

If you've got homebrew:

```sh
brew install convoyinc/tap/yo-sup
```

Otherwise:

1) Clone this repo
2) Add its `bin` directory to your `$PATH`.


## Usage

Add new generators via `sup add` (you can omit the `generator-` prefix):

```sh
sup add react-fullstack
```

Use generators just like you do with `yo`:

```sh
sup react-fullstack
```

Upgrade a generator:

```sh
sup upgrade react-fullstack
```

And when you've moved on, you can remove a generator, too:

```sh
sup remove react-fullstack
```

If you want to update `yo`:

```sh
sup init
```


## How's It Work?

`sup` installs `yo` and any `sup add`ed generators to a path relative to its installation location (`modules/node_modules`).  Then, when passing commands through to `yo`, it simply runs the sandboxed `yo` rather than a copy that's already on your `$PATH`.

:boom: now your generators survive across your various installs of node.  'cause you _are_ a faithful [`n`](https://github.com/tj/n), [`nvm`](https://github.com/creationix/nvm), [`nvs`](https://github.com/jasongin/nvs), etc user; _right_?
