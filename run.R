#!/usr/bin/Rscript --vanilla

# ------------------------------------------------------------------------------
# Convenience script for running the Shiny app in the default web browser.
#
# Copyright (c) 2015 by its authors.
#
# This code is distributed under the BSD3 license. See AUTHORS, LICENSE.
# ------------------------------------------------------------------------------

# Silence complaints about not finding function "loadMethod"
library(methods)

# Load Shiny
library(shiny)

# Host app locally, on random port, and launch it in the default web browser
runApp(appDir = "app", launch.browser = TRUE)
