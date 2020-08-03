class wr_EventHandler : EventHandler
{

  override
  void PlayerEntered(PlayerEvent event)
  {
    if (event.playerNumber != consolePlayer) return;

    let player = players[consolePlayer].mo;

    if (player == NULL) return;

    setMode(player);
  }

// private: ////////////////////////////////////////////////////////////////////////////////////////

  enum Mode
  {
    AllAwake,
    Vanilla,
    AllAsleep,
  }

  private
  void setMode(Actor player)
  {
    switch (wr_mode)
    {
    case AllAwake:  wakeAll(player);
    case AllAsleep: turnAwayWhoLooksAtPlayer(player);
    }
  }

  private
  void wakeAll(Actor player)
  {
    let i = ThinkerIterator.Create();
    Actor monster;
    while (monster = Actor(i.Next()))
    {
      if (!monster.bIsMonster) continue;

      monster.SoundAlert(player);
    }
  }

  private
  void turnAwayWhoLooksAtPlayer(Actor player)
  {
    let i = ThinkerIterator.Create();
    Actor monster;
    while (monster = Actor(i.Next()))
    {
      if (!monster.bIsMonster) continue;

      if (monster.CheckSight(player))
      {
        double awayAngle = -monster.AngleTo(player);
        monster.A_SetAngle(awayAngle);
      }
    }
  }

} // class wr_EventHandler
