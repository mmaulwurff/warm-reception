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
    AllAwakeEvenAmbush,
  }

  private
  void setMode(Actor player)
  {
    String actionClass;
    switch (wr_mode)
    {
    case AllAwake:  actionClass = "wr_Alert"; break;
    case AllAsleep: actionClass = "wr_TurnAwayWhoLooksAtPlayer"; break;
    case AllAwakeEvenAmbush: actionClass = "wr_AlertAmbush"; break;
    case Vanilla: return;
    }

    forEachMonsterDo(wr_Action(new(actionClass)).init(player));
  }

  private static
  void forEachMonsterDo(wr_Action a)
  {
    let i = ThinkerIterator.Create();
    Actor monster;
    while (monster = Actor(i.Next()))
    {
      if (monster.bIsMonster) a.act(monster);
    }
  }

} // class wr_EventHandler

class wr_Action play
{
  wr_Action init(Actor player)
  {
    _player = player;
    return self;
  }

  virtual void act(Actor monster) {}

  protected Actor _player;
}

class wr_Alert : wr_Action
{
  override void act(Actor monster)
  {
    monster.SoundAlert(_player);
  }
}

class wr_AlertAmbush : wr_Action
{
  override void act(Actor monster)
  {
    monster.bAmbush = false;
    monster.SoundAlert(_player);
  }
}

class wr_TurnAwayWhoLooksAtPlayer : wr_Action
{
  override void act(Actor monster)
  {
    if (monster.CheckSight(_player))
    {
      double awayAngle = monster.AngleTo(_player) + 180.0;
      monster.A_SetAngle(awayAngle);
    }
  }
}
