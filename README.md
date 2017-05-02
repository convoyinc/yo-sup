# Yo; Sup?

`sup` wraps [Yeoman](http://yeoman.io/)'s `yo` so that it is installed _globally_, outside of any particular Node installation, along with any generators that you would like to be global.

_But why!?_  Because it can be challenging to manage your yeoman generators when you have a multitude of projects that span multiple node versions.  `sup` lets you set up your generators once, and not have to worry!


## Installation

If you've got homebrew:

```sh
brew install convoyinc/tap/sup
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
